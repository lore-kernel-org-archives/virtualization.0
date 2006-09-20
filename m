From: Zachary Amsden <zach@vmware.com>
Subject: Re: paravirt_ops xen booting
Date: Tue, 19 Sep 2006 17:30:43 -0700
Message-ID: <45108BB3.7020306@vmware.com>
References: <20060920001110.GD7474@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060920001110.GD7474@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> Just a note to let you know we've got domU booting with paravirt_ops
> XenoLinux.  There's still some minor cleanups to do:
>
> - soft watchdog firing
> - inconsistent device probing
> - console on tty1
>
> Then onto smp support, and removing the rest of the limitations
> of the current patchset.
>   =


Congrats!  =A1Mucho dolce vitale!

Should we just allow paravirt to disable soft watchdog?  It really =

doesn't make a lot of sense for paravirt - it should be the hypervisor's =

responsibility, and it can break easily across discontinuous time jumps.

Zach
