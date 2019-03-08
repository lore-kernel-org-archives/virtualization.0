From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Fri, 8 Mar 2019 14:13:45 -0500
Message-ID: <20190308191345.GB26923__15481.997367327$1552072441$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
	<20190307124700-mutt-send-email-mst@kernel.org>
	<20190307191720.GF3835@redhat.com>
	<43408100-84d9-a359-3e78-dc65fb7b0ad1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <43408100-84d9-a359-3e78-dc65fb7b0ad1@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 08, 2019 at 04:58:44PM +0800, Jason Wang wrote:
> Can I simply can set_page_dirty() before vunmap() in the mmu notifier 
> callback, or is there any reason that it must be called within vumap()?

I also don't see any problem in doing it before vunmap. As far as the
mmu notifier and set_page_dirty is concerned vunmap is just
put_page. It's just slower and potentially unnecessary.
