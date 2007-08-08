From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
	entry.S
Date: 08 Aug 2007 15:52:41 +0200
Message-ID: <p738x8mrv4m.fsf__22971.1529602811$1186578033$gmane$org@bingen.suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
	<Pine.LNX.4.58.0708080740490.5921@gandalf.stny.rr.com>
	<200708081424.49896.ak@suse.de>
	<Pine.LNX.4.58.0708080835350.6751@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.58.0708080835350.6751@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 8 Aug 2007, Andi Kleen wrote:
> 
> >
> > > Probably not, but this part of the code I don't fully understand.
> >
> > I would suggest to defer all this until at least one example to test it
> > (except vsmp which is too simple) is around.
> 
> Who uses that code? NMIs and debug regs?  Lguest only has the host handle
> the NMIs (doesn't pass to guest). And we haven't gotten to debug regs. Who
> else uses that part of the code?

I'm not sure I understand your question. You're asking who uses entry.S? 
Answer would be everybody. If you asked something else please reformulate.

-Andi
