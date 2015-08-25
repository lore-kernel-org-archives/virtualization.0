From: Cong Wang <cwang@twopensource.com>
Subject: Re: BUG kmalloc-64 (Not tainted): Poison overwritten
Date: Tue, 25 Aug 2015 14:48:50 -0700
Message-ID: <CAHA+R7Mx7hQyLsLx68vV2Z7qGaRhGxPenX2NaY-cMKj6zfCP=Q__40919.2208004699$1440691153$gmane$org@mail.gmail.com>
References: <CAHA+R7OtN5AyGS-hXwfAj4cfediu0i6+L6K+Z_DcnYaQJj6bhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAHA+R7OtN5AyGS-hXwfAj4cfediu0i6+L6K+Z_DcnYaQJj6bhg@mail.gmail.com>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 25, 2015 at 2:11 PM, Cong Wang <cwang@twopensource.com> wrote:
> Hi, Michael
>
> I just got the following kernel bug while working on Dave's net tree
> in a KVM guest. It looks like a bug in virtio.
>

Hmm, the stack trace is misleading, it could be caused by my own networking
code even though it doesn't show in dmesg. Anyway I can't reproduce it on the
clean -net tree.

I will let you know if it is really a bug.

Thanks.
