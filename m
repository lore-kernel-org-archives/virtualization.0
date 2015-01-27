From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: memory barriers in virtq.lua?
Date: Tue, 27 Jan 2015 18:01:26 +0200
Message-ID: <20150127160126.GA10651@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: n.nikolaev@virtualopensystems.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Nikolay,
I poked at src/lib/virtio/virtq.lua a bit -
I was surprised to find no explicit CPU memory
barriers in the virtq implementation.
These are typically required when using virtio
on smp machines - the spec actually mention where
barriers are necessary.
Are the barriers implicit somehow for lua?
I'd be curious to learn.


Thanks,

-- 
MST
