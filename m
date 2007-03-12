From: Zachary Amsden <zach@vmware.com>
Subject: Re: Virtualization + CPU w/crypto acceleration instructions
Date: Mon, 12 Mar 2007 15:46:20 -0800
Message-ID: <45F5E64C.1050604@vmware.com>
References: <62b0912f0703121235l2001eaadra87e9022a8a8c0db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <62b0912f0703121235l2001eaadra87e9022a8a8c0db@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: virtualization@lists.osdl.org, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Molle Bestefich wrote:
> In a virtualized environment running Xen or VMware, can the guest
> operating systems utilize hardware crypto acceleration such as the
> "PadLock" AES acceleration built into VIA CPUs?

VMware doesn't support VIA CPUs, and I think we would have compatibility =

issues with these instructions.  In general, most hypervisors would need =

to support decoding of the new instructions for complete emulation in =

various fault and corner cases.  In general, I would expect some trouble =

just running a hypervisor or VIA CPUs, as the test matrix is so low I =

can't point even to one working example.  Perhaps someone can correct me =

if they have got one up and running.

UML should work fine though.

Zach
