From: Alexander Graf <agraf@suse.de>
Subject: Re: Virtio_console usage of early printk
Date: Tue, 23 Mar 2010 08:42:56 +0100
Message-ID: <C8492FD8-7268-4CC0-BB43-8E0B07113763__21879.787502303$1269330225$gmane$org@suse.de>
References: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?Fran=E7ois_Diakhate?= <fdiakh@gmail.com>
Cc: amit.shah@redhat.com, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 22.03.2010, at 18:45, Fran=E7ois Diakhate wrote:

> Hi all,
> =

> As far as I can see, early_put_chars is not used by virtio_console
> because it checks whether there is a port available before using it.
> If I understand correctly, this makes it useless because once we have
> a port, we can use the regular virtio transport to output things to
> the console. Does the attached patch seem valid ? Feedback from s390
> and powerpc users who use this functionality would be appreciated.

On S390 we use the hypercall interface with characters instead of memory ad=
dresses as parameters. The hypervisor then decides if the character is an e=
arly printk or a real hypercall.

I'm not sure how PPC handles that - I never used virtio console there.

Either way, early printk does work for S390. So what exactly is this patch =
supposed to fix?


Alex
