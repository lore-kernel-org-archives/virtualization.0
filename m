From: Adrian Bunk <bunk@stusta.de>
Subject: Re: A proposal - binary
Date: Sat, 5 Aug 2006 12:47:35 +0200
Message-ID: <20060805104735.GS25692@stusta.de>
References: <44D1CC7D.4010600@vmware.com>
	<20060804183448.GE11244@sequoia.sous-sol.org>
	<44D3B0F0.2010409@vmware.com> <200608050001.52535.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608050001.52535.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, James.Bottomley@steeleye.com, pazke@donpac.ru
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 05, 2006 at 12:01:52AM +0200, Andi Kleen wrote:
> =

> There is no reason Summit or es7000 or any other subarchitecture =

> would need to do different  virtualization. In fact these subarchitecture=
s =

> are pretty much obsolete by the generic subarchitecture and could be fully
> done by runtime switching.
>...

Has anyone measured the performance impact of rutime CLOCK_TICK_RATE =

switching (since this will no longer allow some compile time =

optimizations in jiffies.h)?

> -Andi

cu
Adrian

-- =


    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli
