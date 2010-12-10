From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/1] Properly check return values of kmalloc and
	vmbus_recvpacket
Date: Fri, 10 Dec 2010 00:20:28 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5622C0B9ED3@TK5EX14MBXC116.redmond.corp.microsoft.com>
References: <1291926209-17120-1-git-send-email-hjanssen@microsoft.com>
	<4D013908.E57C.0030.1@novell.com>
	<alpine.LNX.2.00.1012100108030.25880@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LNX.2.00.1012100108030.25880@swampdragon.chaosbits.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jesper Juhl <jj@chaosbits.net>, Ky Srinivasan <ksrinivasan@novell.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "zbr@ioremap.net" <zbr@ioremap.net>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Jesper Juhl [mailto:jj@chaosbits.net]
> Sent: Thursday, December 09, 2010 4:11 PM
> On Thu, 9 Dec 2010, Ky Srinivasan wrote:
> > I am wondering if it might be better to allocate a page during module
> > startup for dealing with some of these services. Since the protocol
> > guarantees that there cannot be more than one outstanding request from
> > the host side, having a pre-allocated receive buffer would be a more
> > robust solution - we don't have to allocate memory when we cannot
> > afford to sleep and thereby don't have to deal with a class of failure
> > conditions that are not easy to deal with. For instance not being able
> > to shut the guest down because of low memory situation would be bad.
> >
> 
> IMVHO; nicer to have a module fail at load time with ENOMEM than having
> failures later. If memory requirement is known at load time (and is fairly low),
> just allocate what's needed then and then there's no unexpected failure
> later.

Agreed, That is a way neater implementation. I will correct and resubmit.

Thanks,

Hank.
