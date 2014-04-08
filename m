From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/6] virtio-scsi: Enable DIF/DIX modes in SCSI host LLD
Date: Tue, 08 Apr 2014 16:35:06 -0400
Message-ID: <53445D7A.6030301__46016.3500546061$1396989340$gmane$org@redhat.com>
References: <1396819929-29687-1-git-send-email-nab@daterainc.com>	
	<1396819929-29687-7-git-send-email-nab@daterainc.com>	
	<20140407084518.GA14091@redhat.com>	
	<1396861019.19888.25.camel@haakon3.risingtidesystems.com>	
	<20140407090225.GB14183@redhat.com>
	<1396861996.19888.28.camel@haakon3.risingtidesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1396861996.19888.28.camel@haakon3.risingtidesystems.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Sagi Grimberg <sagig@dev.mellanox.co.il>, virtualization@lists.linux-foundation.org, Sagi Grimberg <sagig@mellanox.com>, target-devel <target-devel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Nicholas A. Bellinger" <nab@daterainc.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 07/04/2014 05:13, Nicholas A. Bellinger ha scritto:
>> > I guess we'll still be able to fix it after the merge window -
>> > (or worst case, revert the change) is this what you are suggesting?
>> >
> Yes, but I would think that it is actually fixable.  ;)
>
> Otherwise, a v3.16 merge is an option as well.  It's really your +
> Paolo's call here.

With s/niov/nbytes/, I think the interface is fine.  If you can do it 
this week, it is your call as target maintainer...

I don't have to do much more than give my acked-by for the changes to 
the virtio-scsi drivers, it's up to you whether to use it for 3.15 or 3.16.

Paolo
