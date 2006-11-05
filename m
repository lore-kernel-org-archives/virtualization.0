From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/7] paravirtualization: header and
	stubs	for	paravirtualizing critical operations
Date: Sat, 04 Nov 2006 20:59:51 -0800
Message-ID: <454D6FC7.3040308@vmware.com>
References: <20061029024504.760769000@sous-sol.org>	
	<200611030356.54074.ak@suse.de> <454BA7F7.8030205@vmware.com>	
	<200611032209.40235.ak@suse.de>
	<1162701815.29777.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1162701815.29777.6.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Andi, the patches work against Andrew's tree, and he's merged them in
> rc4-mm2.  There are a few warnings to clean up, but it seems basically
> sound.
>
> At this point I our think time is better spent on beating those patches
> up, rather than going back and figuring out why they don't work in your
> tree.
>   =


This begs the question - should we rebase the paravirt-ops patchset =

against -rc4-mm2?  I almost did it today, but didn't want to stomp on =

anybody else's toes.

Zach
