From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 05/22] virtio: add support for 64 bit features.
Date: Fri, 22 Mar 2013 22:12:43 +0200
Message-ID: <CAK=Wgbbdz0g=8Ps--=njY=6RYZU0yBfXscz9tP5tTHZ4QsstMg@mail.gmail.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-6-git-send-email-rusty@rustcorp.com.au>
	<20130321110614.24c6ed08@gondolin>
	<CAJK669aeEAkPrtrjM5e1pwVgvqU8CGo6TFdm5hGUEJ1PpFZLAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJK669aeEAkPrtrjM5e1pwVgvqU8CGo6TFdm5hGUEJ1PpFZLAA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjurbren@gmail.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Brian Swetland <swetland@google.com>, Linus Walleij <linus.walleij@linaro.org>, Erwan YVIN <Erwan.Yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 22, 2013 at 4:50 PM, Sjur Br=E6ndeland <sjurbren@gmail.com> wro=
te:
> I guess you would need to update the feature bits in remoteproc as well?
> e.g. something like:
>
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index faf3332..148a503 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -296,8 +296,8 @@ struct fw_rsc_vdev_vring {
>  struct fw_rsc_vdev {
>         u32 id;
>         u32 notifyid;
> -       u32 dfeatures;
> -       u32 gfeatures;
> +       u64 dfeatures;
> +       u64 gfeatures;
>         u32 config_len;
>         u8 status;
>         u8 num_of_vrings;

We will break existing firmware if we do that.

Initially we thought it's a good idea to announce that remoteproc's
binary interface isn't stable so we could keep changing it, but at
this point changing the binary interface means pain for too many
people.

I'm thinking that at this stage any changes to the binary interface
will have to bump up the binary version so we can still support older
images, despite our "unstable" policy.
