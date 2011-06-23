From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 02/02] virtio: Add virtio platform driver
Date: Thu, 23 Jun 2011 11:26:34 +0900
Message-ID: <BANLkTimSj9iMeYJ8X7SCocVDfbGUPGotRw__39156.6193815835$1308796128$gmane$org@mail.gmail.com>
References: <20110621102605.1382.90232.sendpatchset@t400s>
	<20110621102623.1382.71841.sendpatchset@t400s>
	<BANLkTi=tut=Y4fc4tkT8wt_q1azJOYaDoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=tut=Y4fc4tkT8wt_q1azJOYaDoQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: mst@redhat.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Mike,

On Wed, Jun 22, 2011 at 3:27 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tue, Jun 21, 2011 at 06:26, Magnus Damm wrote:
>> +config VIRTIO_PLATFORM
>> + =A0 =A0 =A0 tristate "Platform driver for virtio devices (EXPERIMENTAL=
)"
>> + =A0 =A0 =A0 select VIRTIO
>> + =A0 =A0 =A0 select VIRTIO_RING
>> + =A0 =A0 =A0 select VIRTIO_LGUEST
>> + =A0 =A0 =A0 ---help---
>> + =A0 =A0 =A0 =A0This drivers provides support for virtio based paravirt=
ual device
>> + =A0 =A0 =A0 =A0drivers over a platform bus.
>> +
>> + =A0 =A0 =A0 =A0If unsure, say N.
>
> be nice to add a note as to the name of the module if the user selects "M"

Yes, good idea!

>> --- /dev/null
>> +++ work/drivers/virtio/virtio_platform.c =A0 =A0 =A0 2011-03-03 16:07:3=
1.000000000 +0900
>> --- /dev/null
>> +++ work/include/linux/virtio_platform.h =A0 =A0 =A0 =A02011-03-03 15:56=
:54.000000000 +0900
>
> both files lack a comment block at the top
> /*
> =A0* one line desc of file
> =A0*
> =A0* copyright
> =A0*
> =A0* license blurb
> =A0*/

Sure! I will include these changes in the next version!

Thank you!

/ magnus
