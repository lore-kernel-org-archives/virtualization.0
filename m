From: Vasile Catalin-B50542 <catalin.vasile@freescale.com>
Subject: [vhost] sending data to guest, async
Date: Wed, 6 May 2015 11:09:41 +0300
Message-ID: <5549CC45.7000504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

1. Is there a method to send data to the guest from vhost with the 
current API?
2. Is there a way I could do this asynchronously? From what I see from
the vhost-net and vhost-scsi model, data from the quest is mapped onto
vq->iov. So I can't process data out of order and then send something
resulting from this, because on vq->iov there would be something else
mapped (another job mapped).
