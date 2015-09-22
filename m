From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 4/6] virtio-gpu: add 3d/virgl support
Date: Tue, 22 Sep 2015 17:18:18 +0200
Message-ID: <1442935098.13084.31.camel__32312.3843096711$1442935116$gmane$org@redhat.com>
References: <1442828417-6165-1-git-send-email-kraxel@redhat.com>
	<1442828417-6165-5-git-send-email-kraxel@redhat.com>
	<20150921130110-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150921130110-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Airlie <airlied@linux.ie>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> >  static unsigned int features[] = {
> > +#ifdef __LITTLE_ENDIAN
> > +	VIRTIO_GPU_FEATURE_VIRGL,
> > +#endif
> >  };
> 
> Why is virgl LE specific? Just curious.

gallium command stream is native endian, and we only support little
endian guests on little endian hosts for that reason.

Supporting bigendian guests on bigendian hosts should be possible too
(with a VIRGl_BE feature flag), but with even the powerpc world moving
to little endian I see little reason to actually bother.

To be clear: this affects 3d acceleration only, 2d mode works fine on
every host/guest endian combination.

> > +#ifdef __LITTLE_ENDIAN
> > +	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_FEATURE_VIRGL))
> > +		vgdev->has_virgl_3d = true;
> > +#endif
> 
> You might be able to get by without this ifdef as
> VIRTIO_GPU_FEATURE_VIRGL won't be set without it.

Yes, right, this #ifdef can go away.

> > +int virtio_gpu_cmd_get_capset_info(struct virtio_gpu_device *vgdev, int idx)
> > +{
> > +	struct virtio_gpu_get_capset_info *cmd_p;
> > +	struct virtio_gpu_vbuffer *vbuf;
> > +	void *resp_buf;
> > +
> > +	resp_buf = kzalloc(sizeof(struct virtio_gpu_resp_capset_info),
> > +			   GFP_KERNEL);
> > +	if (!resp_buf)
> > +		return -ENOMEM;
> > +
> > +	cmd_p = virtio_gpu_alloc_cmd_resp
> > +		(vgdev, &virtio_gpu_cmd_get_capset_info_cb, &vbuf,
> > +		 sizeof(*cmd_p), sizeof(struct virtio_gpu_resp_capset_info),
> > +		 resp_buf);
> > +	memset(cmd_p, 0, sizeof(*cmd_p));
> > +
> > +	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_GET_CAPSET_INFO);
> > +	cmd_p->capset_index = cpu_to_le32(idx);
> > +	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
> > +	return 0;
> > +}
> > +
> 
> I note that all callers ignore the recurn code from
> virtio_gpu_queue_ctrl_buffer.
> 
> Is there a reason it can't fail?

It can only fail when vgdev->vqs_ready is false.  Which can only happen
when we are about to unload the driver.  In that case we probably don't
worry much about the failure ...

> Shouldn't it be made void then?

I guess we should ...

> > +	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_CTX_CREATE);
> > +	cmd_p->hdr.ctx_id = cpu_to_le32(id);
> > +	cmd_p->nlen = cpu_to_le32(nlen);
> > +	strncpy(cmd_p->debug_name, name, 63);
> > +	cmd_p->debug_name[63] = 0;
> 
> sizeof (cmd_p->debug_name) - 1 will be a but prettier.

Agree.

> > diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> > index 478be52..7f4f9ce 100644
> > --- a/include/uapi/linux/virtio_gpu.h
> > +++ b/include/uapi/linux/virtio_gpu.h
> > @@ -40,6 +40,8 @@
> >  
> >  #include <linux/types.h>
> >  
> > +#define VIRTIO_GPU_FEATURE_VIRGL 0
> > +
> 
> I'd prefer it named VIRTIO_GPU_F_VIRGL for consistency with other
> devices.

Makes sense, I'll change it.

thanks,
  Gerd
