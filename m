From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 15:29:20 +0300
Message-ID: <46CADAA0.5010107__29600.0226088383$1187699557$gmane$org@qumranet.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>	<1187313953.6449.70.camel@localhost.localdomain>	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>	<1187336618.6449.106.camel@localhost.localdomain>	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>	<1187652496.19435.141.camel@localhost.localdomain>	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
	<1187683122.19435.171.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187683122.19435.171.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Partly the horror of the code, but mainly because it is an in-order
> ring.  You'll note that we use a reply ring, so we don't need to know
> how much the other side has consumed (and it needn't do so in order).
>   

Yes, it's quite nice: by using two in-order rings, you get out-of-order 
completions.  Simple _and_ efficient.


-- 
error compiling committee.c: too many arguments to function
