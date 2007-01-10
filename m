From: James Morris <jmorris@namei.org>
Subject: Re: APIC clock setup dependent on PAE ?
Date: Wed, 10 Jan 2007 09:52:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701100952320.9615@d.namei>
References: <Pine.LNX.4.64.0701100933220.8582@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701100933220.8582@d.namei>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 10 Jan 2007, James Morris wrote:

> Why are these APIC clock init hooks dependent on CONFIG_X86_PAE ?

And should it perhaps be

#ifdef CONFIG_X86_LOCAL_APIC'd ?



- James
-- =

James Morris
<jmorris@namei.org>
