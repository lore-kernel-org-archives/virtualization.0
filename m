From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/6] Staging: hv: Unify hyper-v device abstractions
Date: Fri, 25 Feb 2011 22:21:22 -0500
Message-ID: <20110226032122.GA25737@home.goodmis.org>
References: <1298685930-30806-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298685930-30806-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>, r@home.goodmis.org
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi!

Just an FYI,

When sending out patch series, could you send out a [PATCH 0/6] first,
and have all other patches a reply to that patch. Both git and quilt
have ways to do this.

The reason is that the linux kernel mailing list gets over 600 emails a
day, and for those of us that skim through, we like to hit [make thread
as read] when we are not interested in the thread or patch set. When
people send out a set of patches that are all individual, this means I
need to hit this command for every patch.

Also do not think I'm just picking on you. I've complained to several
people about doing this. One just recently sent out 21 patches.

Thanks,

-- Steve
