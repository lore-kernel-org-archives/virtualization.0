From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [RFC] kvm tools: Implement multiple VQ for virtio-net
Date: Tue, 22 Nov 2011 10:14:16 -0800
Message-ID: <20111122101416.7bccf6c6__819.144273600791$1321985694$gmane$org@nehalam.linuxnetplumber.net>
References: <1321049521-26376-1-git-send-email-levinsasha928@gmail.com>
	<20111113102428.GD15322@redhat.com> <1321196430.2425.2.camel@sasha>
	<4EC07729.3050303@gmail.com>
	<CAOJsxLE4yRO+5XncrDEzVh5-RGXG+=HGTAmQ=bX=KMsDqf=feA@mail.gmail.com>
	<20111114130507.GA18288@redhat.com>
	<877h31ortx.fsf@rustcorp.com.au> <20111116072317.GG5433@redhat.com>
	<87bos6b936.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87bos6b936.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, gorcunov@gmail.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias.hejun@gmail.com>, virtualization@lists.linux-foundation.org, Pekka Enberg <penberg@kernel.org>, Sasha Levin <levinsasha928@gmail.com>, netdev@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

I have been playing with userspace-rcu which has a number of neat
lockless routines for queuing and hashing. But there aren't kernel versions
and several of them may require cmpxchg to work.
