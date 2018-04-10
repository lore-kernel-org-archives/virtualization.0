From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v29 1/4] mm: support reporting free page blocks
Date: Tue, 10 Apr 2018 13:54:29 -0700
Message-ID: <20180410135429.d1aeeb91d7f2754ffe7fb80e__2547.30693200163$1523393573$gmane$org@linux-foundation.org>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
	<1522031994-7246-2-git-send-email-wei.w.wang@intel.com>
	<20180326142254.c4129c3a54ade686ee2a5e21@linux-foundation.org>
	<20180410211719-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180410211719-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, huangzhichao@huawei.com, pbonzini@redhat.com, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Apr 2018 21:19:31 +0300 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> 
> Andrew, were your questions answered? If yes could I bother you for an ack on this?
> 

Still not very happy that readers are told that "this function may
sleep" when it clearly doesn't do so.  If we wish to be able to change
it to sleep in the future then that should be mentioned.  And even put a
might_sleep() in there, to catch people who didn't read the comments...

Otherwise it looks OK.
