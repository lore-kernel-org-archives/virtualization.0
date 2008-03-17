From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_net/virtio_ring: fix race in enable_cb
Date: Mon, 17 Mar 2008 07:30:44 +0100
Message-ID: <200803170730.44218.borntraeger__15238.1804342896$1205735666$gmane$org@de.ibm.com>
References: <200803141417.05696.borntraeger@de.ibm.com>
	<200803171248.14570.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803171248.14570.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> Are you seeing the "Unlikely: restart svq failed" message in the logs?  If 
> not, I don't think it can be this race.

No, I dont see the message, but this message only happens for guest->host 
traffic in the xmit function. I was fixing the poll function - which has no 
printk.
I added the disable_cb in the xmit function only  to adopt to changed 
enable_cb semantics.

I double checked my theory with a printk in enable_cb. The more_used check 
was true several times for the receiving virtqueue. 

Christian
