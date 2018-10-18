From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/8] drm/virtio: track created object state
Date: Thu, 18 Oct 2018 07:57:38 +0200
Message-ID: <20181018055738.g3noucn6k4qizckq__38964.9936267689$1539842138$gmane$org@sirius.home.kraxel.org>
References: <20181001103222.11924-1-kraxel@redhat.com>
	<20181001103222.11924-6-kraxel@redhat.com>
	<CAPM=9tzpzxv9TorRDWX3=sj_=EEqu3gyU2+AyWAFVHLPzZVcew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPM=9tzpzxv9TorRDWX3=sj_=EEqu3gyU2+AyWAFVHLPzZVcew@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 18, 2018 at 11:25:22AM +1000, Dave Airlie wrote:
> On Mon, 1 Oct 2018 at 20:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Track whenever the virtio_gpu_object is already created (i.e. host knows
> > about it) in a new variable.  Add checks to virtio_gpu_object_attach()
> > to do nothing on objects not created yet.
> >
> > Make virtio_gpu_ttm_bo_destroy() use the new variable too, instead of
> > expecting hw_res_handle indicating the object state.
> 
> Is there a potential patch ordering issue here? If this patch changes
> the code to avoid using hw_res_handle,
> is after patches that start filling in hw_res_handle in places we
> haven't filled it in before.
> Maybe this patch should happen earlier.

Didn't run into trouble in testing, but yes, it might be an issue in
error paths.  I'll reorder the patches.

cheers,
  Gerd
