From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Date: Tue, 7 Jan 2020 13:16:50 +0100
Message-ID: <fe6e7e90-3004-eb7a-9ed8-b53a7667959f__5598.00501666672$1578399433$gmane$org@de.ibm.com>
References: <c022e1d6-0d57-ae07-5e6b-8e40d3b01f4b@de.ibm.com>
 <20191218100926-mutt-send-email-mst@kernel.org>
 <2ffdbd95-e375-a627-55a1-6990b0a0e37a@de.ibm.com>
 <20200106054041-mutt-send-email-mst@kernel.org>
 <08ae8d28-3d8c-04e8-bdeb-0117d06c6dc7@de.ibm.com>
 <20200107042401-mutt-send-email-mst@kernel.org>
 <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
 <20200107065434-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200107065434-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07.01.20 12:55, Michael S. Tsirkin wrote:

> 
> I pushed batched-v3 - same head but bisect should work now.
> 

With 
commit 38ced0208491103b50f1056f0d1c8f28e2e13d08 (HEAD)
Author:     Michael S. Tsirkin <mst@redhat.com>
AuthorDate: Wed Dec 11 12:19:26 2019 -0500
Commit:     Michael S. Tsirkin <mst@redhat.com>
CommitDate: Tue Jan 7 06:52:42 2020 -0500

    vhost: use batched version by default


I have exactly one successful ping and then the network inside the guest is broken (no packet
anymore).

So you could consider this commit broken (but in a different way and also without any
guest reboot necessary).


bisect log:
git bisect start
# bad: [d2f6175f52062ee51ee69754a6925608213475d2] vhost: use vhost_desc instead of vhost_log
git bisect bad d2f6175f52062ee51ee69754a6925608213475d2
# good: [d1281e3a562ec6a08f944a876481dd043ba739b9] virtio-blk: remove VIRTIO_BLK_F_SCSI support
git bisect good d1281e3a562ec6a08f944a876481dd043ba739b9
# good: [fac7c0f46996e32d996f5c46121df24a6b95ec3b] vhost: option to fetch descriptors through an independent struct
git bisect good fac7c0f46996e32d996f5c46121df24a6b95ec3b
# bad: [539eb9d738f048cd7be61f404e8f9c7d9d2ff3cc] vhost: batching fetches
git bisect bad 539eb9d738f048cd7be61f404e8f9c7d9d2ff3cc
