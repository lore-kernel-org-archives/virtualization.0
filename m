From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 14/21] Xen-paravirt: Add XEN config
 options and disableunsupported config options.
Date: Fri, 16 Feb 2007 19:00:39 +0000
Message-ID: <C1FBAFD7.99AB%keir__14037.2966685847$1171652487$gmane$org@xensource.com>
References: <45D5EDDB.7050404@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946064AbXBPTAn@vger.kernel.org>
In-Reply-To: <45D5EDDB.7050404@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Keir Fraser <keir@xensource.com>
Cc: xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Ian Pratt <Ian.Pratt@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Steven Hand <steven.hand@cl.cam.ac.uk>, Christian Limpach <Christian.Limpach@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 17:46, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

> Keir Fraser wrote:
>> This initial patchset does not include save/restore support anyway, so in
>> fact it would be consistent to have CONFIG_PREEMPT configurable. I'm sure
>> that we are going to have some nasty bugs to fix up as a result, but we
>> can't fix them until we find them! Then we can convert our save/restore code
>> to use the freezer before submitting it for inclusion.
> OK.  So that makes the only config restriction the 100Hz ticks.

We can extend the Xen timer interface quite easily and get rid of this one
too. In fact it doesn't *much* matter if the CONFIG_HZ differs from the Xen
ticker rate -- we modified the Linux timer ISR to handle timer interrupts at
arbitrary times already. The only drawback is that jiffies updates in burts
if CONFIG_HZ is higher than the actual tick rate, and this can affect some
calibration constants and cause Linux to print out some weird values at
start-of-day.

 -- Keir
