From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] fix boot crash when freeing initrd memory
Date: Wed, 01 Nov 2006 15:59:23 -0800
Message-ID: <454934DB.4060700@vmware.com>
References: <Pine.LNX.4.44.0611011831450.1490-100000@redline.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0611011831450.1490-100000@redline.boston.redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: James Morris <jmorris@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

James Morris wrote:
> On Wed, 1 Nov 2006, James Morris wrote:
>
>   =

>>> Is this booting native or under Xen?  I put the BUG_ON in there since i=
f =

>>> it isn't page-aligned, freeing the page would seem to be freeing =

>>> something else unexpectedly...  I think ChrisW was triggering this =

>>> BUG_ON at one point, but I don't think we've worked out what's going on =

>>> here.
>>>       =

>> This is booting native, with patches applied but nothing selected (no Xe=
n, =

>> VMI or lhype).
>>     =

>
> Here's what it's trying to free:
>
> free_init_pages: what=3Dc02aef98 begin=3D4158582784 end=3D4160683928
>
> (in hex, begin & end are 0xf7def000 and 0xf7eff98)
>   =


James, can you mail us your .config?  I've seen this once or twice, but =

it always was config dependent, and I never succeeded at bisecting the =

config properly to determine what caused it to appear.

Thanks,

Zach
