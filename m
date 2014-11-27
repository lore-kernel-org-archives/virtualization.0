From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 01/45] virtio: use u32, not bitmap for struct
	virtio_device's features
Date: Thu, 27 Nov 2014 17:34:14 +0100
Message-ID: <20141127173414.20424b62@thinkpad-w530>
References: <1417091078-24611-1-git-send-email-mst@redhat.com>
	<1417091078-24611-2-git-send-email-mst@redhat.com>
	<20141127171542.3dbb2bc2@thinkpad-w530>
	<20141127162804.GB27124@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141127162804.GB27124@redhat.com>
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
Cc: rusty@au1.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Sudeep Dutt <sudeep.dutt@intel.com>, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>, Pawel Moll <pawel.moll@arm.com>, Siva Yerramreddy <yshivakrishna@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>, linux390@de.ibm.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> That's the whole reason for the patch.
> 
> I guess you disagree with it, but it's much easier
> to deal with simple integers.
> 

Well, I can live with it :)

clear_bit() and friends are just easier to understand when scanning the code
(at least for me).
