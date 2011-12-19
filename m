From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [Xen-devel] linux-next: Tree for Dec 19 (xen)
Date: Mon, 19 Dec 2011 16:47:57 -0400
Message-ID: <20111219204757.GB29852@andromeda.dapyr.net>
References: <20111219185556.f07c1f43e28cfd594aaa5fe0@canb.auug.org.au>
	<4EEF9F44.8080707@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4EEF9F44.8080707@xenotime.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, linux-next@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 19, 2011 at 12:32:04PM -0800, Randy Dunlap wrote:
> On 12/18/2011 11:55 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20111216:
> 
> 
> drivers/xen/xenbus/xenbus_dev_frontend.c: In function 'xenbus_init':
> drivers/xen/xenbus/xenbus_dev_frontend.c:609:2: error: implicit declaration of function 'xen_domain'
> 
> Full randconfig file is attached.

Fixed. Thx!
