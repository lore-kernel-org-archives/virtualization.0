From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Virtualization + CPU w/crypto acceleration instructions
Date: Mon, 12 Mar 2007 17:04:06 -0700
Message-ID: <45F5EA76.4080805@goop.org>
References: <62b0912f0703121235l2001eaadra87e9022a8a8c0db@mail.gmail.com>
	<45F5E64C.1050604@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F5E64C.1050604@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: virtualization@lists.osdl.org, Molle Bestefich <molle.bestefich@gmail.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> VMware doesn't support VIA CPUs, and I think we would have compatibility =

> issues with these instructions.  In general, most hypervisors would need =

> to support decoding of the new instructions for complete emulation in =

> various fault and corner cases. =


Using a crypto instruction to update a pagetable would be... interesting ;)

    J
