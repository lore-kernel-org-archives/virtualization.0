From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/6] virtio_balloon: transitional interface
Date: Wed, 1 Apr 2015 09:44:48 +0200
Message-ID: <20150401094236-mutt-send-email-mst@redhat.com>
References: <1427831230-28044-1-git-send-email-mst@redhat.com>
	<1427831230-28044-2-git-send-email-mst@redhat.com>
	<87mw2sy0fo.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87mw2sy0fo.fsf@rustcorp.com.au>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 01, 2015 at 02:17:23PM +1030, Rusty Russell wrote:
> I would leave the device *exactly* as is, ugly structure packing and
> all.

But why?  It's going to be used for years, might as well make it clean?

-- 
MST
