From: Steven Liu <lingjiujianke@gmail.com>
Subject: Re: [PATCH] fix a code style in drivers/char/virtio_console.c
Date: Tue, 18 May 2010 14:41:35 +0800
Message-ID: <AANLkTinkel3TW8cCY3YCIw_savLuwcQKR67ebX7EmmSU__8818.17237609557$1274192752$gmane$org@mail.gmail.com>
References: <AANLkTilW8zZxCOrdiefZ4ZtixprI58LzDZ6Cz03z4lFk@mail.gmail.com>
	<20100518052230.GA1706@amit-laptop.redhat.com>
	<AANLkTimXLkzb-CyhbkOaubAOiSsIkGKW0y5Cblrwfvst@mail.gmail.com>
	<20100518063241.GB27262@amit-laptop.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100518063241.GB27262@amit-laptop.redhat.com>
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

okay, i see, thanks for your regards :)

2010/5/18 Amit Shah <amit.shah@redhat.com>:
> Hello,
>
> On (Tue) May 18 2010 [13:41:29], Steven Liu wrote:
>> Hi, Amit,
>>
>> =A0 =A0 if 'err' initialised in this path, it needn't do err =3D -ENOMEM
>> after,isn't it?
>
> What I mean is if we later add some code that just does:
>
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
>
> then 'ret' can be -ENOMEM, as it was initialised to, which would be
> fine. But if a later patch adds something like:
>
> + =A0 =A0 =A0 ret =3D -EIO;
> + =A0 =A0 =A0 err =3D ...
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> +
> =A0 =A0 =A0 =A0err =3D ...
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
>
> In this case, the 2nd if() would now return EIO instead of ENOMEM as
> earlier.
>
> Also, this style of coding can prevent uninitialised usage of 'ret', eg:
>
>
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
>
> fail:
> =A0 =A0 =A0 =A0return ret;
>
> In this case, the compiler will warn about 'ret' being used
> uninitialised.
>
> This is just a coding style issue. I had initially coded it the way your
> patch does, but Rusty asked me to change that and I like this new style
> better: there's less scope for surprises.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Amit
>
