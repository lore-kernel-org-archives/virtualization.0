From: Andi Kleen <ak@suse.de>
Subject: Re: paravirt_ops queue rebased
Date: Sun, 6 May 2007 23:49:40 +0200
Message-ID: <200705062349.40343.ak@suse.de>
References: <463E0E8D.3050806@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <463E0E8D.3050806@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 06 May 2007 19:21:17 Jeremy Fitzhardinge wrote:
> I just rebased my paravirt_ops patch queue to current git.  Looks like
> almost all the pre-req patches are now in, which is nice.
> 
> The only missing thing from your patches was you sched_clock patches and
> the sched_clock paravirt-op.  Are there still problems with either your
> sched_clock patch

There were problems with my patch and yours dependend on it so I deferred both.

> or the paravirt patch?  Should I resubmit the 
> paravirt-sched_clock patch based on git?

Not needed, I still have it.
 
> The only other general patches before the Xen series I have left in my
> queue are:
> 
>     i386-common-smp.patch
>     i386-fix-voyager-build.patch
>     vsyscall-note-use-elfnote_h.patch
> 
> I obviously don't depend the voyager patch, but I tweaked it a bit to
> apply to the current git tree.
> 
> How is your patch queue looking now?  Is there much left?

Only a few patches left, like unwinder, vDSO, sched-clock. 

-Andi
