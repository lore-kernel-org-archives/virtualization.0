From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: RFT: virtio_net: limit xmit polling
Date: Sun, 17 Jul 2011 12:42:01 +0300
Message-ID: <20110717094201.GB17404__22167.3325206668$1310895764$gmane$org@redhat.com>
References: <20110629084206.GA14627@redhat.com>
	<CA4493AD.2E273%roprabhu@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA4493AD.2E273%roprabhu@cisco.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Roopa Prabhu <roprabhu@cisco.com>
Cc: Krishna Kumar2 <krkumar2@in.ibm.com>, habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 14, 2011 at 12:38:05PM -0700, Roopa Prabhu wrote:
> Michael, below are some numbers I got from one round of runs.
> Thanks,
> Roopa

Thanks!
At this point it does not appear like there's any measureable
impact from moving the polling around.

-- 
MST
