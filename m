From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RESEND 5/5] vhost-blk: Add vhost-blk support
Date: Fri, 20 Jul 2012 11:31:26 +0100
Message-ID: <CAJSP0QWWKdLCMw1_A=W85iUTFgOu15gEpEOs7hg7ULjxcbMLRA@mail.gmail.com>
References: <1342169711-12386-1-git-send-email-asias@redhat.com>
	<1342169711-12386-6-git-send-email-asias@redhat.com>
	<87mx2vrjdl.fsf@codemonkey.ws> <20120719130957.GD9303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120719130957.GD9303@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Khoa Huynh <khoa@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 19, 2012 at 2:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jul 19, 2012 at 08:05:42AM -0500, Anthony Liguori wrote:
>> Of course, the million dollar question is why would using AIO in the
>> kernel be faster than using AIO in userspace?
>
> Actually for me a more important question is how does it compare
> with virtio-blk dataplane?

Hi Khoa,
I think you have results of data-plane and vhost-blk?  Is the
vhost-blk version identical to Asias' recent patches?

Stefan
