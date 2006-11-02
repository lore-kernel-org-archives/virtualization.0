From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for
	paravirtualizing critical operations
Date: Wed, 1 Nov 2006 23:13:13 -0800
Message-ID: <20061101231313.4c91a9a9.akpm@osdl.org>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org>
	<200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1162376827.23462.5.camel@localhost.localdomain>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This patch breaks `make headers_check' in mysterious ways:

  CHECK   include/linux/netfilter_ipv4/ip_conntrack_tcp.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_sctp.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_protocol.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper_h323_types.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper_h323_asn1.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper.h
make[2]: *** [/usr/src/devel/usr/include/asm/.check.setup.h] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [asm-i386] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [headers_check] Error 2
