From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCHv3] virtio-spec: 64 bit features, used/avail event, fixes
Date: Wed, 03 Aug 2011 18:15:33 +0200
Message-ID: <4E397425.90808__15627.7868817144$1312388495$gmane$org@redhat.com>
References: <20110601102548.GA11013@redhat.com>
	<87ei3dxas0.fsf@rustcorp.com.au>
	<20110803160518.GA16563@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110803160518.GA16563@redhat.com>
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
Cc: Krishna Kumar2 <krkumar2@in.ibm.com>, habanero@linux.vnet.ibm.com, kvm@vger.kernel.org, steved@us.ibm.com, Shirley Ma <mashirle@us.ibm.com>, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, Tom Lendacky <tahm@linux.vnet.ibm.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

   Hi,

> E.g. with 32 bridges, and 32 devices behind each one,
> the available 64K space gets us only 64 bytes per device.

15 bridges (with io window enabled) max, the smallest io window you can 
assign to a bridge is 4k, and you need some space for the devices on the 
root bus ...

cheers,
   Gerd
