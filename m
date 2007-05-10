From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [1/2] [NET] link_watch: Move link watch list into net_device
Date: Thu, 10 May 2007 15:45:42 -0700
Message-ID: <4643A096.7000909@goop.org>
References: <464395E5.2090500@goop.org>	<20070510151426.d808384f.akpm@linux-foundation.org>	<46439B19.7010706@goop.org> <20070510.152552.117703057.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070510.152552.117703057.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, herbert@gondor.apana.org.au, hch@infradead.org, ak@suse.de, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk, netdev@vger.kernel.org, jeff@garzik.org, shemminger@linux-foundation.org, rusty@rustcorp.com.au, Valdis.Kletnieks@vt.edu
List-Id: virtualization@lists.linuxfoundation.org

David Miller wrote:
> I'm not so certain now that we know it's the jiffies wrap point :-)
>
> The fixes in question are attached below and they were posted and
> discussed on netdev:
>   

Yep, this patch gets rid of my spinning thread.  I can't find this patch
or any discussion on marc.info; is there a better netdev list archive?

    J
