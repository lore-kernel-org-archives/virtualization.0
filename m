From: Zachary Amsden <zach@vmware.com>
Subject: Re: Paravirt-ops next steps
Date: Thu, 09 Nov 2006 19:48:06 -0800
Message-ID: <4553F676.4030303@vmware.com>
References: <4553F1A2.2050802@vmware.com>
	<20061109193744.94d7afa2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061109193744.94d7afa2.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andi Kleen <ak@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> It'd be better to develop and test this work on top of Thomas's stuff, as
> that's what 2.6.20 will doubtless look like.  That means working against
> -mm.  Once Thomas's patches are in mainline then the patches will apply to
> Andi's tree too and I can send them over to him.
>
> That way, the patch-applying-order equals mainstream-merging-order equals
> chronological-writing-order, which is generally a good thing.
>   =


Sounds sane.  Are Thomas's patches in -rc5-mm1?  If so, we should rebase =

paravirt-ops, although I don't want to lose any paravirt patches that =

you've dropped because they were merged to Andi.  Don't know if that is =

the case, but I did see a bunch of "merged into a subsystem tree" drops =

from -mm related to paravirt.

Thanks,

Zach
