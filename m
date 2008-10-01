From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 12:56:34 -0700
Message-ID: <48E3D5F2.4090708__40972.5138139494$1222891244$gmane$org@goop.org>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<48E3BC47.60900@zytor.com> <48E3BD83.2090801@goop.org>
	<48E3BE65.2050909@zytor.com> <48E3C32B.3090701@goop.org>
	<48E3C4C3.1050903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3C4C3.1050903@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Dan Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "avi@redhat.com" <avi@redhat.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> What you'd want, at least, is a standard CPUID identification and 
> range leaf at the top.  256 leaves is a *lot*, though; I'm not saying 
> one couldn't run out, but it'd be hard.  Keep in mind that for large 
> objects there are "counting" CPUID levels, as much as I personally 
> dislike them, and one could easily argue that if you're doing 
> something that would require anywhere near 256 leaves you probably are 
> storing bulk data that belongs elsewhere.

I agree, but it just makes the proposal a bit more brittle.

> Of course, if we had some kind of central authority assigning 8-bit 
> IDs that would be even better, especially since there are tools in the 
> field which already scan on 64K boundaries.  I don't know, though, how 
> likely it is that we'll have to deal with 256 hypervisors.

I'm assuming that the likelihood of getting all possible vendors - 
current and future - to agree to a scheme like this is pretty small.  We 
need to come up with something that will work well when there are 
non-cooperative parties to deal with.

> I agree completely, of course (except that "what hypervisor is this" 
> still has limited usage, especially when it comes to dealing with bug 
> workarounds.  Similar to the way we use CPU vendor IDs and stepping 
> numbers for physical CPUs.)

I guess.  Its certainly useful to be able to identify the hypervisor for 
bug reporting and just general status information.  But making 
functional changes on that basis should be a last resort.

    J
