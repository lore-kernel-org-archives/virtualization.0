From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [1/2] [NET] link_watch: Move link watch list into net_device
Date: Thu, 10 May 2007 15:53:08 -0700
Message-ID: <20070510225308.GL3505@sequoia.sous-sol.org>
References: <464395E5.2090500@goop.org> <20070510151426.d808384f.akpm@linux-foundation.org> <46439B19.7010706@goop.org> <20070510.152552.117703057.davem@davemloft.net> <4643A096.7000909@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4643A096.7000909@goop.org>
Sender: netdev-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, herbert@gondor.apana.org.au, hch@infradead.org, ak@suse.de, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk, netdev@vger.kernel.org, jeff@garzik.org, shemminger@linux-foundation.org, rusty@rustcorp.com.au, Valdis.Kletnieks@vt.edu
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Yep, this patch gets rid of my spinning thread.  I can't find this patch
> or any discussion on marc.info; is there a better netdev list archive?

See the "linkwatch bustage in git-net" thread on netdev

http://thread.gmane.org/gmane.linux.network/61800/focus=61812
