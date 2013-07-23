From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 05/10] virtio: console: update private_data in struct
	file only on successful open
Date: Tue, 23 Jul 2013 13:48:19 +0530
Message-ID: <20130723081819.GB25551@amit-x200.redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
	<a012f8e8c562c84c2302e57e5360291ef7d4ff21.1374177234.git.amit.shah@redhat.com>
	<87ip03b1e7.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ip03b1e7.fsf@rustcorp.com.au>
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
Cc: stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 22 Jul 2013 [15:07:52], Rusty Russell wrote:
> Amit Shah <amit.shah@redhat.com> writes:
> > Mateusz Guzik points out that we update the 'file' struct's private_data
> > field before we've successfully done all our checks.  This means we can
> > return an error with the private_data field updated.  This could lead to
> > problems.
> >
> > Fix by moving the assignment after all checks are done.
> 
> No, this is a bit weird, but it's fine.
> 
> If we fail open, filp will be destroyed; we won't be told about it, and
> private_data will never be accessed.

Thanks!  Will drop this.

		Amit
