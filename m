From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [kvm-devel] [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 10:11:59 -0700
Message-ID: <97D612E30E1F88419025B06CB4CF1BE10259AB81__10218.3025599972$1180545166$gmane$org@scsmsx412.amr.corp.intel.com>
References: <465D9A77.90505@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <465D9A77.90505@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Anthony Liguori wrote:
> > Sure.  It adds a few more cycles onto native though (two memory
reads,
> > and some math).
> 
> As opposed to a serializing control-register read?  I think that's
> probably a win.
> 
>     J
> 

And actually you don't need the write to CR3 to flush TLB because the
one to CR4 does it. Or does kvm_flush_tlb_kernel assume that CR3 is
updated at the same time?

Jun
---
Intel Open Source Technology Center
