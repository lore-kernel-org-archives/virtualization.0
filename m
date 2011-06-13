From: Krishna Kumar2 <krkumar2@in.ibm.com>
Subject: Re: [PATCHv2 RFC 0/4] virtio and vhost-net capacity handling
Date: Mon, 13 Jun 2011 19:14:07 +0530
Message-ID: <OFF64BF5BD.B405A000-ON652578AE.004AE88C-652578AE.004B23D1__20306.8982730203$1307972587$gmane$org@in.ibm.com>
References: <cover.1307029008.git.mst@redhat.com>
	<20110607160830.GB17581@redhat.com>
	<OFE36F9C2B.43D9DB04-ON652578AE.0048E1AB-652578AE.004A1462@in.ibm.com>
	<20110613133513.GA29884@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110613133513.GA29884@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> wrote on 06/13/2011 07:05:13 PM:

> > I ran the latest patches with 1K I/O (guest->local host) and
> > the results are (60 sec run for each test case):
>
> Hi!
> Did you apply this one:
> [PATCHv2 RFC 4/4] Revert "virtio: make add_buf return capacity remaining"
> ?
>
> It turns out that that patch has a bug and should be reverted,
> only patches 1-3 should be applied.
>
> Could you confirm please?

No, I didn't apply that patch. I had also seen your mail
earlier on this patch breaking receive buffer processing
if applied.

thanks,

- KK
