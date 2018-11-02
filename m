From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] Add vhost_blk driver
Date: Fri, 2 Nov 2018 16:38:19 -0400
Message-ID: <20181102163809-mutt-send-email-mst__9262.18552417613$1541190979$gmane$org@kernel.org>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
	<20181102182123.29420-2-v.mayatskih@gmail.com>
	<20181102142645-mutt-send-email-mst@kernel.org>
	<CAGF4SLj0TtW_kP935UdqswjT9qaznh_BR7sxW2ALozy7yTJ8vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGF4SLj0TtW_kP935UdqswjT9qaznh_BR7sxW2ALozy7yTJ8vg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 02, 2018 at 03:24:13PM -0400, Vitaly Mayatskih wrote:
> On Fri, Nov 2, 2018 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > > +     if (type == VIRTIO_BLK_T_GET_ID) {
> > > +             char s[] = "vhost_blk";
> >
> > Isn't this supposed to return the serial #?
> 
> Yes, that gets a bit tricky here... Disk serial number is specified in
> QEMU command line parameters, so it needs to be passed to vhost_blk
> when qemu attaches the disk backend. That can be done (now? in a
> following incremental patch?).

I'add an ioctl now.

> Also other vhost work does the same with GET_ID, if that's matter.
> 
> I'll fix the rest, thanks for review!
> 
> -- 
> wbr, Vitaly
