From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 5/6] drm/virtio: drop fencing in
	virtio_gpu_resource_create_ioctl
Date: Mon, 18 Mar 2019 12:35:04 +0100
Message-ID: <20190318113504.hm5i76n6467vcy7g__12746.2281425082$1552908990$gmane$org@sirius.home.kraxel.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
	<20190130094338.14203-6-kraxel@redhat.com>
	<CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> virtio_gpu_execbuffer_ioctl
> virtio_gpu_resource_create_ioctl with fence resource
> virtio_gpu_wait_ioctl with that fence resource --> associated with a
> GL wait on the host side

After a long break (sidetracked with other stuff) I've finally sent v3
which should address this.

cheers,
  Gerd
