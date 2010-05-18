From: Steven Liu <lingjiujianke@gmail.com>
Subject: Re: [PATCH] fix a code style in drivers/char/virtio_console.c
Date: Tue, 18 May 2010 13:41:29 +0800
Message-ID: <AANLkTimXLkzb-CyhbkOaubAOiSsIkGKW0y5Cblrwfvst__42497.7764756933$1274192487$gmane$org@mail.gmail.com>
References: <AANLkTilW8zZxCOrdiefZ4ZtixprI58LzDZ6Cz03z4lFk@mail.gmail.com>
	<20100518052230.GA1706@amit-laptop.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100518052230.GA1706@amit-laptop.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi, Amit,

    if 'err' initialised in this path, it needn't do err =3D -ENOMEM
after,isn't it?



Best regards


2010/5/18 Amit Shah <amit.shah@redhat.com>:
> On (Tue) May 18 2010 [13:17:22], Steven Liu wrote:
>> fix a code style in drivers/char/virtio_console.c
>>
>> Signed-off-by: Liu Qi <lingjiujianke@gmail.com>
>
> NACK.
>
> This style is deliberate and follows Rusty's style: if we end up using
> 'err' uninitialised in some code path, it can get flagged by source
> checkers.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Amit
>
