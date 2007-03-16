From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 21/26] Xen-paravirt_ops: Use the hvc
 console infrastructure for Xen console
Date: Fri, 16 Mar 2007 10:31:49 +0000
Message-ID: <C2202295.BA49%keir__45110.7369423427$1174041161$gmane$org@xensource.com>
References: <20070316095851.GB301@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753459AbXCPKcE@vger.kernel.org>
In-Reply-To: <20070316095851.GB301@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Keir Fraser <Keir.Fraser@xensource.com>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 16/3/07 09:58, "Ingo Molnar" <mingo@elte.hu> wrote:

>> These mb()'s are pretty standard for lock-free producer/consumer
>> rings. Write descriptor /then/ write the updated producer. Read the
>> producer /then/ read any descriptors revealed by this new producer
>> value.
> 
> then use rmb()/wmb(). Rarely does a ring protocol truly need mb().

It's needed for writing data /after/ reading the consumer index that shows
you have space to write. Looking through xenbus_comms.c I think all the
barriers are correct except there is a spurious extra mb() in xb_read(),
where there is a later rmb() which is sufficient by itself. All the others
have a purpose.

 -- Keir
