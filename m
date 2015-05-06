From: Vasile Catalin-B50542 <catalin.vasile@freescale.com>
Subject: [vhost] vhost_get_vq_desc, vq->iov mapping
Date: Wed, 6 May 2015 13:01:51 +0300
Message-ID: <5549E68F.7030206@freescale.com>
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
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

 From what I know, qemu and vhost backends use some functions in order 
to access the memory between the guest and the backend.
 From what I see, vhost does this with vhost_get_vq_desc().
How much do vq->iov mappings remain valid? Does it get unmapped at some 
time (you could answer me within vhost-net or vhost-scsi
as examples)?
