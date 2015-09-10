From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 3/5] update virtio gpu driver: add 3d/virgl support
Date: Thu, 10 Sep 2015 13:15:25 +0100
Message-ID: <CACvgo51MOc_ZbjxEikz7DWMAAwNPsZYF0J+=Ejg41wy8MFG33A__40437.6019876965$1441900596$gmane$org@mail.gmail.com>
References: <1441798946-26233-1-git-send-email-kraxel@redhat.com>
	<1441798946-26233-4-git-send-email-kraxel@redhat.com>
	<CACvgo51Y7j0ka46Rfq2eBvXzP4q8Jc6x4j-JrYHDLkH6_xOh7w@mail.gmail.com>
	<CAPM=9txn4yGwQg+ZdL5Z9ZtFzSnw3QfUtAWT5mSXgB_JL00pYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPM=9txn4yGwQg+ZdL5Z9ZtFzSnw3QfUtAWT5mSXgB_JL00pYA@mail.gmail.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10 September 2015 at 11:32, Dave Airlie <airlied@gmail.com> wrote:
>> > --- /dev/null
>> > +++ b/include/uapi/drm/virtgpu_drm.h
>> > @@ -0,0 +1,163 @@
>>
>> > +
>> > +struct drm_virtgpu_3d_box {
>> > +       uint32_t x, y, z;
>> > +       uint32_t w, h, d;
>> > +};
>> > +
>> There was a similar case (multiple variables declared on a single
>> line) in drm core that caused confusion and we broke the 32bit compat.
>> I thought I mention it - not advocating for/against the above declaration.
>
>
> probably should put some newlines alright,
>
>>
>
>> > +struct drm_virtgpu_3d_transfer_to_host {
>> > +       uint32_t bo_handle;
>> > +       struct drm_virtgpu_3d_box box;
>> > +       uint32_t level;
>> > +       uint32_t offset;
>> > +};
>> > +
>> > +struct drm_virtgpu_3d_transfer_from_host {
>> > +       uint32_t bo_handle;
>> > +       struct drm_virtgpu_3d_box box;
>> > +       uint32_t level;
>> > +       uint32_t offset;
>> > +};
>> > +
>> Afaics these seems to be used by the ioctls. If so the current
>> declarations are not 32bit compat safe. Things will also go badly if
>> you consider expanding struct drm_virtgpu_3d_box in the distant
>> future. A u32 pad after bo_handle and a 'pointer' to struct
>
> I'm curious what you think we can add to a 3d box.
>
None from the top of my head I'm afraid. But I'm wondering if one
cannot keep things flexible considering the cost/downside of the
approach is minimal.

> So this one is fine, no need to align it either I don't think, though I
> should confirm that.
>
> Maybe for safety we can pull the other uint32_t above the box.
>
pahole did complain on my system, but please do - was low on caffeine
so I could have botched something.

Regards
Emil
