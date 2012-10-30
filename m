From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Tue, 30 Oct 2012 17:29:25 +0200
Message-ID: <20121030152925.GA7023@redhat.com>
References: <1340742778-11282-1-git-send-email-fes@google.com>
	<20120910090521.GB18544@redhat.com>
	<CAGTjWtBa5jW6+y1k6zZmD9TUNHBgv8WRbO_iy7huY_dJSumStw@mail.gmail.com>
	<20120910195931.GD20721@redhat.com>
	<CAGTjWtCiqjkR_Ze=0-ebO08+eziz6c8TXLb+O1iiArRQeSE6zw@mail.gmail.com>
	<20120910211018.GB21484@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120910211018.GB21484@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Waychison <mikew@google.com>
Cc: Frank Swiderski <fes@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Rik van Riel <riel@redhat.com>, kvm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 11, 2012 at 12:10:18AM +0300, Michael S. Tsirkin wrote:
> > On the plus side, having an exit taken here on each page turns out to
> > be relatively cheap, as the vmexit from the page fault should be
> > faster to process as it is fully handled within the host kernel.
> > 
> > Perhaps some combination of both methods is required? I'm not sure :\
> 
> Perhaps some benchmarking is in order :)
> Can you try telling host, potentially MADV_WILL_NEED
> in that case like qemu does, then run your proprietary test
> and see if things work well enough?

Ping. Had a chance to try that?

-- 
MST
