From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH] virtio_console: Let unconnected rproc device receive data.
Date: Tue, 12 Feb 2013 11:01:10 +0100
Message-ID: <CAJK669Y2=FRDLH9RbyzfVLQaF+wUNoziBzWZA=7mfG7VMmZWBw@mail.gmail.com>
References: <1358425362-4517-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125091024.GB30483@amit.redhat.com>
	<81C3A93C17462B4BBD7E272753C105792458D7DEEF@EXDCVYMBSTM005.EQ1STM.local>
	<CAJK669a7yr2Fo2Asrthtq5osLynurkuM_k_yO1GTsOTNaho+Dg@mail.gmail.com>
	<20130212094242.GC22567@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130212094242.GC22567@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, Erwan.Yvin@stericsson.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 12, 2013 at 10:42 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
...
> > > > How about setting port->guest_connected = true in the init routines
> > > > instead?  Keeps this code path cleaner.
> > >
> > > Agree, I'll respin this patch.
> >
> > Hm, Rusty has already picked this up.
>
> I don't see it in virtio-next. Do you?


Yes I do, see:

http://git.kernel.org/?p=linux/kernel/git/rusty/linux.git;a=commitdiff;h=1f8051876a194d7f7fe7834d9853f240d6b4b9ab;hp=226364766f936d249e408de03821468c1bf11dda

Regards,
Sjur
