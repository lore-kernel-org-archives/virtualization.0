From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
Date: Tue, 3 Sep 2019 11:00:31 -0400
Message-ID: <20190903105954-mutt-send-email-mst@kernel.org>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
	<20190830095928-mutt-send-email-mst@kernel.org>
	<41b8eb4b-0d3b-f103-9ec4-332a903612ee@nutanix.com>
	<20190831134218-mutt-send-email-mst@kernel.org>
	<6454e12b-470b-cce6-5570-3fb92cbc916d@nutanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6454e12b-470b-cce6-5570-3fb92cbc916d@nutanix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matej Genci <matej.genci@nutanix.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 02, 2019 at 09:56:42AM +0000, Matej Genci wrote:
> On 8/31/2019 6:43 PM, Michael S. Tsirkin wrote:
> > On Fri, Aug 30, 2019 at 05:58:23PM +0000, Matej Genci wrote:
> >> On 8/30/2019 3:02 PM, Michael S. Tsirkin wrote:
> >>> On Tue, Aug 27, 2019 at 03:20:57PM +0000, Matej Genci wrote:
> >>>> Compilers such as g++ 7.3 complain about assigning void* variable to
> >>>> a non-void* variable (like struct pointers) and pointer arithmetics
> >>>> on void*.
> >>>>
> >>>> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> >>>> ---
> >>>>    include/uapi/linux/virtio_ring.h | 9 +++++----
> >>>>    1 file changed, 5 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> >>>> index 4c4e24c291a5..2c339b9e2923 100644
> >>>> --- a/include/uapi/linux/virtio_ring.h
> >>>> +++ b/include/uapi/linux/virtio_ring.h
> >>>> @@ -168,10 +168,11 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
> >>>>    			      unsigned long align)
> >>>>    {
> >>>>    	vr->num = num;
> >>>> -	vr->desc = p;
> >>>> -	vr->avail = p + num*sizeof(struct vring_desc);
> >>>> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> >>>> -		+ align-1) & ~(align - 1));
> >>>> +	vr->desc = (struct vring_desc *)p;
> >>>> +	vr->avail = (struct vring_avail *)((uintptr_t)p
> >>>> +		+ num*sizeof(struct vring_desc));
> >>>> +	vr->used = (struct vring_used *)(((uintptr_t)&vr->avail->ring[num]
> >>>> +		+ sizeof(__virtio16) + align-1) & ~(align - 1));
> >>>>    }
> >>>>    
> >>>>    static inline unsigned vring_size(unsigned int num, unsigned long align)
> >>>
> >>> I'm not really interested in building with g++, sorry.
> >>> Centainly not if it makes code less robust by forcing
> >>> casts where they weren't previously necessary.
> >>
> >> Can you elaborate on how these casts make the code less robust?
> > 
> > If we ever change the variable types build will still pass
> > because of the cast.
> > 
> 
> Wouldn't that be the case in the original as well?
> You're assigning void*, which is implicitly cast to everything.


Right. And if we change that void * to something else,
build will fail. Not so with a cast.

> >> They aren't necessary in C but I think being explicit can improve
> >> readability as argued in
> >> https://urldefense.proofpoint.com/v2/url?u=https-3A__softwareengineering.stackexchange.com_a_275714&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=dbPDDn52JgZndd-WPvGcL5PLZTrms-72TItYJx-If5I&m=sw6xxC2EOF9g3XtUKuI6OvT5xhYF7XcWBqyQvGb-UMw&s=QWoZHF4XlOzPesnnbfsf1_KORrzkXb6yfd6yQGCwepc&e=
> >>
> >>>
> >>> However, vring_init and vring_size are legacy APIs anyway,
> >>> so I'd be happy to add ifndefs that will allow userspace
> >>> simply hide these functions if it does not need them.
> >>>
> >>
> >> I feel like my patch is a harmless way of allowing this header
> >> to be used in C++ projects, but I'm happy to drop it in lieu of
> >> the guards if you feel strongly about it.
> >>
> >> Thanks.
> >> Matej
> > 
> > Yea let's not even start.
> > 
> 
> Sure. I can re-send the patch with guards. But for my own sake,
> can you elaborate on the above?
> 
> >>>
> >>>> -- 
> >>>> 2.22.0
> >>>>
> >>
> 
