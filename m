From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 3/3] virtio_net: limit xmit polling
Date: Thu, 2 Jun 2011 18:44:31 +0300
Message-ID: <20110602154431.GB11300__47451.0801294402$1307029799$gmane$org@redhat.com>
References: <cover.1306921434.git.mst@redhat.com>
	<1ec8eec325839ecf2eac9930a230361e7956047c.1306921434.git.mst@redhat.com>
	<87pqmwj3am.fsf@rustcorp.com.au> <20110602133425.GJ7141@redhat.com>
	<OF990F08C5.2ECE35B1-ON652578A3.004DC0FA-652578A3.004E3FE4@in.ibm.com>
	<20110602144346.GA7995@redhat.com>
	<OFFF109303.D838CAE2-ON652578A3.0053357D-652578A3.00549366@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <OFFF109303.D838CAE2-ON652578A3.0053357D-652578A3.00549366@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Krishna Kumar2 <krkumar2@in.ibm.com>
Cc: habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 02, 2011 at 08:56:42PM +0530, Krishna Kumar2 wrote:
> Return value in free_old_xmit() was wrong.

Could you check my latest RFC pls?

-- 
MST
