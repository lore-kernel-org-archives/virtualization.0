From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCHv3] virtio-spec: 64 bit features, used/avail event, fixes
Date: Thu, 04 Aug 2011 09:55:13 +0200
Message-ID: <4E3A5061.4060009__19023.9479336471$1312444578$gmane$org@redhat.com>
References: <20110601102548.GA11013@redhat.com>
	<87ei3dxas0.fsf@rustcorp.com.au>
	<20110803160518.GA16563@redhat.com> <4E397425.90808@redhat.com>
	<20110803163923.GA17244@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110803163923.GA17244@redhat.com>
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

> Hmm, wait, we could go 32 bit, then we are not limited to 32
> bridges anymore, right? Does our bios support that?

How you want go to 32bit? io space (not mmio) is fixed at 16bit in x86, 
isn't it?

cheers,
   Gerd
