From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 06 Jun 2013 17:22:44 +0200
Message-ID: <51B0A944.8030704@redhat.com>
References: <87bo7ktvaw.fsf@codemonkey.ws> <20130605162029.GB26561@redhat.com>
	<51AFA92B.2030203@zytor.com> <87fvwwmdmf.fsf@codemonkey.ws>
	<51AFB3DD.1050902@zytor.com> <874ndcb47i.fsf@codemonkey.ws>
	<51AFC4A6.6070607@zytor.com> <877gi8nk9e.fsf@codemonkey.ws>
	<20130606063432.GQ4725@redhat.com> <51B0A578.2030104@redhat.com>
	<20130606151012.GD4725@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130606151012.GD4725@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

>> For seabios itself this isn't a big issue, see pci_{readl,writel} in
>> src/pci.c.  When called in 16bit mode it goes into 32bit mode
>> temporarily, just for accessing the mmio register.  ahci driver uses it,
>> xhci driver (wip atm) will use that too, and virtio-{blk,scsi} drivers
>> in seabios can do the same.
>>
> Isn't this approach broken? How can SeaBIOS be sure it restores real
> mode registers to exactly same state they were before entering 32bit
> mode?

Don't know the details of that magic.  Kevin had some concerns on the
stability of this, so maybe there is a theoretic hole.  So far I havn't
seen any issues in practice, but also didn't stress it too much.
Basically only used that with all kinds of boot loaders, could very well
be it breaks if you try to use that with more esoteric stuff such as dos
extenders, then hit unhandled corner cases ...

cheers,
  Gerd
