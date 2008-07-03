From: "Christopher S. Aker" <caker@theshore.net>
Subject: Re: 2.6.26-rc8 pv_ops causes Unhandled invalid opcode fault/trap
Date: Thu, 03 Jul 2008 12:00:09 -0400
Message-ID: <486CF789.7030700__32250.6045959473$1215101169$gmane$org@theshore.net>
References: <486CE463.3070002@theshore.net> <486CF3F7.3030309@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <486CF3F7.3030309@goop.org>
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
Cc: Xen-devel <xen-devel@lists.xensource.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Is this consistent or sporadic?  

Consistently fails to boot, across a few test boxes, slightly different 
Xen versions -- all around Xen 3.2.1, same config.

> Does it depend on how much guest memory you give it?

No.  Tried with 128, 360, 5000.  They all fail in the same way.

> What was the last kernel version which worked?

I built a 2.6.25.10 pv_ops this morning and it boots fine.

> Were there any other errors/warnings printed here?

Nope.  Just some whitespace.

>> (XEN) traps.c:413:d332 Unhandled invalid opcode fault/trap [#6] on 
>> VCPU 0 [ec=0000]
>> (XEN) domain_crash_sync called from entry.S
>> (XEN) Domain 332 (vcpu#0) crashed on cpu#0:
>> (XEN) ----[ Xen-3.2.1-rc5  x86_64  debug=y  Not tainted ]----
>> (XEN) CPU:    0
>> (XEN) RIP:    e019:[<00000000c0103b55>]
> 
> Could you decode this to see which function this corresponds to?

I'd love to know how for future reference, but for now I've placed the 
files here:

http://www.theshore.net/~caker/xen/pvops-bug1/

Thanks,
-Chris
