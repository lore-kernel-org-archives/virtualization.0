From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: question about "struct kvm_segment"
Date: Fri, 30 May 2014 22:49:51 +0200
Message-ID: <5388EEEF.8080108@redhat.com>
References: <CAG4AFWbMxbGsLrd_pGzUmwfmq4E3BKDHCZN6xKKqMt2-1dHOXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG4AFWbMxbGsLrd_pGzUmwfmq4E3BKDHCZN6xKKqMt2-1dHOXw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jidong Xiao <jidong.xiao@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 20/05/2014 04:25, Jidong Xiao ha scritto:
> Hi,
>
> The structure kvm_segment is defined as follows:
>
> struct kvm_segment {
>         __u64 base;
>         __u32 limit;
>         __u16 selector;
>         __u8  type;
>         __u8  present, dpl, db, s, l, g, avl;
>         __u8  unusable;
>         __u8  padding;
> };
>
> Since the VMX spec defines base is 64 bits, limit is 32bits, selector
> is 16bits, understandably, __u64, __u32, __u16 is used for them
> respectively.
>
> However, the VMX spec defines that the access rights is 32bits, which
> includes a 4 bits type, 2 bits dpl, and 1 bit for the
> present,dpl,db,s,l,g,avl. So why here they are all defined as __u8? It
> means that, each of them is represented by 8bits? This looks
> inconsistent with the VMX spec.

This is not a VMX definition, it's part of the ioctl interface between 
KVM and user-mode programs.

For the conversion code see vmx_get_segment and vmx_set_segment.  These 
should be never called in hot paths, except unfortunately when doing 
nested virtualization.

Paolo
