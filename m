From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Tue, 29 Jan 2008 15:29:53 +0100
Message-ID: <200801291529.53808.borntraeger@de.ibm.com>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
	<479EDDCE.8000000@qumranet.com> <479F3528.9040203@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479F3528.9040203@us.ibm.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 29. Januar 2008 schrieb Anthony Liguori:
> That's not what I was agreeing too.  I don't want to plumb an ABI 
> interface through virtio for each device.  This is what I didn't like 
> about having an ABI field in the first place.  I'm thinking we should 
> just drop both of these and instead just rely on feature bits.

Me also updating the our prototype code to the latest levels...

And I agree with Anthony. Feature bits seems to be a much better solution 
than ABI versions.


Christian
