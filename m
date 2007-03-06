From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] ARP notify option
Date: Tue, 06 Mar 2007 11:04:29 -0800
Message-ID: <45EDBB3D.604@goop.org>
References: <20070301164214.4a40bc59@freekitty>	<45E7764A.7000100@goop.org>	<20070301173030.754514ec@freekitty>	<20070305.203536.92584097.davem@davemloft.net> <20070306105132.52c77491@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070306105132.52c77491@freekitty>
Sender: netdev-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, ak@muc.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, chrisw@sous-sol.org, zach@vmware.com, rusty@rustcorp.com.au, ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk, netdev@vger.kernel.org, jeff@garzik.org
List-Id: virtualization@lists.linuxfoundation.org

Stephen Hemminger wrote:
> This adds another inet device option to enable gratuitous ARP
> when device is brought up or address change. This is handy for
> clusters or virtualization.
>   

Thanks Stephen.  Haven't tested this yet, but it definitely cleans up a
warty corner of netfront.

    J
