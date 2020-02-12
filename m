From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 13/22] compat_ioctl: scsi: move ioctl handling into drivers
Date: Wed, 12 Feb 2020 22:49:49 +0100
Message-ID: <CAK8P3a0oPpMC8367sEs+9Ae=wFH30BHAq+aRDbWLyeVLuNOnEw@mail.gmail.com>
References: <20200102145552.1853992-1-arnd@arndb.de> <20200102145552.1853992-14-arnd@arndb.de>
 <20200212211452.GA5726@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200212211452.GA5726@latitude>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, Doug Gilbert <dgilbert@interlog.com>, =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, Alexander Viro <viro@zeniv.linux.org.uk>, Dongli Zhang <dongli.zhang@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Damien Le Moal <damien.lemoal@wdc.com>, John Garry <john.garry@huawei.com>, Martin Wilck <mwilck@suse.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Gustavo A. R. Silva" <gustavo@embedde>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 12, 2020 at 10:15 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> On 2020 Jan 02, Arnd Bergmann wrote:

>
> Error in getting drive hardware properties
> Error in getting drive reading properties
> Error in getting drive writing properties
> __________________________________
>
> Disc mode is listed as: CD-DA
> ++ WARN: error in ioctl CDROMREADTOCHDR: Bad address
>
> cd-info: Can't get first track number. I give up.

Right, there was also a report about breaking the Fedora installer,
see https://bugzilla.redhat.com/show_bug.cgi?id=1801353

There is a preliminary patch that should fix this, I'll post a
version with more references tomorrow:
https://www.happyassassin.net/temp/0001-Replace-.ioctl-with-.compat_ioctl-in-three-appropria.patch

      Arnd
